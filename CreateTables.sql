CREATE TABLE [dbo].[Customer]
(
	[customerID] INT NOT NULL PRIMARY KEY IDENTITY,
	[customerUsername] VARCHAR(30) NOT NULL,
)


CREATE TABLE [dbo].[Artist]
(
	[artistID] INT NOT NULL PRIMARY KEY IDENTITY,
	[artistUsername] VARCHAR(30) NOT NULL,
)


CREATE TABLE [dbo].[Artwork]
(
    [artworkID] INT NOT NULL PRIMARY KEY IDENTITY,
    [artworkName] VARCHAR(30) NOT NULL,
    [artworkDescription] VARCHAR(420) NOT NULL,
    [artworkImagePath] VARCHAR(100) NOT NULL,
    [artworkPrice] FLOAT NOT NULL,
    [artworkStock] INT NOT NULL,
    [artistID] INT NOT NULL,
	[artworkListStatus] VARCHAR(8) NOT NULL,
    FOREIGN KEY ([artistID]) REFERENCES [dbo].[Artist]([artistID])
)


CREATE TABLE [dbo].[Wishlist] (
    [wishlistID] INT NOT NULL PRIMARY KEY IDENTITY,
    [customerID] INT NOT NULL,
    [artworkID] INT NOT NULL,
    [originalArtworkPrice] FLOAT NOT NULL,
    FOREIGN KEY ([customerID]) REFERENCES [dbo].[Customer]([customerID]),
    FOREIGN KEY ([artworkID]) REFERENCES [dbo].[Artwork]([artworkID])
)


CREATE TABLE [dbo].[Orders] (
    [orderID] INT NOT NULL PRIMARY KEY IDENTITY,
    [orderDate] VARCHAR(30) NOT NULL,
    [customerID] INT NOT NULL,
    [deliveryAddress] VARCHAR(200) NOT NULL,
    FOREIGN KEY ([customerID]) REFERENCES [dbo].[Customer]([customerID])
)


CREATE TABLE [dbo].[OrderList] (
    [orderListID] INT NOT NULL PRIMARY KEY IDENTITY,
    [orderID] INT NOT NULL,
    [artworkID] INT NOT NULL,
    [orderStatus] VARCHAR(30) NOT NULL,
    [orderQuantity] INT NOT NULL,
    [purchasePrice] FLOAT NOT NULL,
    FOREIGN KEY ([orderID]) REFERENCES [dbo].[Orders]([orderID]),
    FOREIGN KEY ([artworkID]) REFERENCES [dbo].[Artwork]([artworkID])
)


CREATE TABLE [dbo].[Payment] (
    [paymentID] INT NOT NULL PRIMARY KEY IDENTITY,
    [orderID] INT NOT NULL,
    [cardType] VARCHAR(10) NOT NULL,
    [cardNumber] VARCHAR(16) NOT NULL,
    FOREIGN KEY ([orderID]) REFERENCES [dbo].[Orders]([orderID])
)

CREATE TABLE [dbo].[Cart]
(
	[cartID] INT NOT NULL PRIMARY KEY IDENTITY,
	[customerID] INT NOT NULL,
	[artworkID] INT NOT NULL,
	[orderQuantity] INT NOT NULL,
	FOREIGN KEY ([customerID]) REFERENCES [dbo].[Customer]([customerID]),
	FOREIGN KEY ([artworkID]) REFERENCES [dbo].[Artwork]([artworkID])
)