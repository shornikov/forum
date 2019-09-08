<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/root">
        <html>
            <head>
                <title>
                    <xsl:value-of select="name"/>
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
                                    <a>
                                        <xsl:attribute name="href">
                                            <xsl:value-of select="link"/>
                                        </xsl:attribute>
                                        <xsl:value-of select="name"/>
                                    </a>
                                </li>
                            </xsl:for-each>
                        </ol>
                    </nav>

                    <ul>
                        <xsl:for-each select="subSections/node">
                            <li>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="linkName"/>
                                    </xsl:attribute>
                                    <xsl:value-of select="name"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>

                    <xsl:if test="name!='forum'">
                        <button class="btn btn-primary" type="button" id="addpost">add Topic</button>
                        <div id="addPostDialog" class="jumbotron d-none mt-5">
                            <form action="/addtopic" method="post">
                                <input type="hidden" name="razdel">
                                    <xsl:attribute name="value">
                                        <xsl:value-of select="linkName"/>
                                    </xsl:attribute>
                                </input>
                                <div class="form-group col-12">
                                    <label for="title">Title</label>
                                    <input id="title" name="title" class="form-control" required="required"/>
                                </div>
                                <div class="form-group col-6">
                                    <label for="author">author</label>
                                    <input id="author" name="author" class="form-control" required="required"/>
                                </div>
                                <div class="form-group col-12">
                                    <label for="text">Post content</label>
                                    <textarea id="text" name="text" class="form-control" required="required" rows="4"/>
                                </div>
                                <div class="form-group col-12">
                                    <button class="btn btn-primary" type="submit">Create post</button>
                                </div>
                            </form>
                        </div>
                    </xsl:if>

                    <div class="row mt-5">
                        <div class="col-12">
                            <table class="table table-bordered">
                                <xsl:apply-templates select="topics/node"/>
                            </table>
                        </div>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <!--    todo возможно надо сделать внешний темплейт. Пока он сильно похож на темплейт из topic.xsl-->
    <xsl:template match="topics/node">
        <div class="col-12 alert alert-secondary">
            <div class="col-12">
                <div class="data">
                    <xsl:value-of select="dateCreate"/>
                </div>
                <div class="author">
                    <xsl:value-of select="author"/>
                </div>
            </div>
            <div class="col-12">
                <a>
                    <xsl:attribute name="href">
                        <xsl:value-of select="'topic/'"/>
                        <xsl:value-of select="id"/>
                    </xsl:attribute>
                    <xsl:value-of select="title"/>
                </a>
            </div>
        </div>
    </xsl:template>

</xsl:stylesheet>
