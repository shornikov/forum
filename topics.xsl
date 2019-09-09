<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/root">
        <html>
            <head>
                <title>
                    <xsl:value-of select="posts/node[1]/dateCreate"/>
                </title>
                <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
                      integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
                      crossorigin="anonymous"/>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"/>
                <script src="/scripts.js"/>
                <link href="/css.css" rel="stylesheet"/>
            </head>
            <body>
                <div class="container">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <xsl:for-each select="breadcrumb/node">
                                <li class="breadcrumb-item">
                                    <a href="{link}">
                                        <xsl:value-of select="name"/>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ol>
                    </nav>

                    <h1>
                        <xsl:value-of select="posts/node[1]/title"/>
                    </h1>
                    <!--                    <div class="col-12 alert alert-primary">-->
                    <!--                        <div class="col-12">-->
                    <!--                            <div class="data">-->
                    <!--                                <xsl:value-of select="dateCreate"/>-->
                    <!--                            </div>-->
                    <!--                            <div class="author">-->
                    <!--                                <xsl:value-of select="author"/>-->
                    <!--                            </div>-->
                    <!--                        </div>-->
                    <!--                        <div class="col-12">-->
                    <!--                            <xsl:value-of select="text"/>-->
                    <!--                        </div>-->
                    <!--                    </div>-->
                    <div class="posts">
                        <xsl:apply-templates select="posts"/>
                    </div>
                    <div class="col-12 jumbotron mt-5 p-2 ">
                        <form action="/addpost" method="post">
                            <!--                        Установка фокуса на форму приведет к отматыванию страницы вниз. Нафиг надо...-->
                            <input type="hidden" name="razdel" value="{posts/node[1]/hierarhyId}">
                            </input>
                            <input type="hidden" name="parentId" value="{posts/node[1]/id}">
                            </input>
                            <div class="form-group col-6">
                                <label for="author">Author</label>
                                <input id="author" name="author" class="form-control" required="required" rows="4"/>
                            </div>
                            <div class="form-group col-12">
                                <label for="text">Post content</label>
                                <textarea id="text" name="text" class="form-control" required="required" rows="4"/>
                            </div>
                            <div class="form-group col-12">
                                <button class="btn btn-primary" type="submit">Reply</button>
                            </div>
                        </form>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <xsl:template match="posts/node">
        <!--        используем css first-child всесто этого треша-->
        <!--        <xsl:variable name="color">-->
        <!--            <xsl:choose>-->
        <!--                <xsl:when test="position()=1">-->
        <!--                    <xsl:copy-of select="'primary'"/>-->
        <!--                </xsl:when>-->
        <!--                <xsl:otherwise>-->
        <!--                    <xsl:copy-of select="'secondary'"/>-->
        <!--                </xsl:otherwise>-->
        <!--            </xsl:choose>-->
        <!--        </xsl:variable>-->
        <!--        <div class="col-12 alert alert-{$color}">-->

        <div class="col-12 alert alert-secondary">
            <div class="col-12">
                <div class="data">
                    <xsl:value-of select="dateCreate"/>
                </div>
                <div class="author">
                    <xsl:value-of select="author"/>
                </div>
            </div>
            <div class="col-12 text">
                <xsl:value-of select="text"/>
            </div>
        </div>
    </xsl:template>
</xsl:stylesheet>
