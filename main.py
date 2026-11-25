from mcp.server.fastmcp import FastMCP

# Create an MCP server
mcp = FastMCP("MathManager", host="0.0.0.0", port=8082)


# Tool : add two numbers
@mcp.tool()
async def add(a: int, b: int) -> int:
    """Add two numbers"""
    return a + b


# Run with streamable HTTP transport:::  this is good when MCP server is deployed as separate HTTP service.
# Run with 'stdio' transport instead for local MCP Server
if __name__ == "__main__":
    mcp.run(transport="streamable-http")

