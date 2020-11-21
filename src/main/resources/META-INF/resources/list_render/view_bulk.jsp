<%@ page import="com.liferay.commerce.model.CPDefinitionInventory" %>
<%@ page import="com.liferay.commerce.service.CPDefinitionInventoryLocalServiceUtil" %>
<%@ include file="/META-INF/resources/init.jsp" %>

<%
    CPContentHelper cpContentHelper = (CPContentHelper)request.getAttribute(CPContentWebKeys.CP_CONTENT_HELPER);
    CPDataSourceResult cpDataSourceResult = (CPDataSourceResult)request.getAttribute(CPWebKeys.CP_DATA_SOURCE_RESULT);

    List<CPCatalogEntry> cpCatalogEntries = cpDataSourceResult.getCPCatalogEntries();
    CommerceContext commerceContext = (CommerceContext)request.getAttribute(CommerceWebKeys.COMMERCE_CONTEXT);

    String redirect = PortalUtil.getCurrentURL(request);
%>
<c:choose>
    <c:when test="<%= !cpCatalogEntries.isEmpty() %>">
        <div class="dataset-display-content-wrapper">
            <aui:button-row>
                <aui:button type="button" value="Parcel 1" onClick="orderParcel(1)"/>
                <aui:button type="button" value="Parcel 2" onClick="orderParcel(2)"/>
                <aui:button type="button" value="Parcel 3" onClick="orderParcel(3)"/>
                <aui:button type="button" value="Parcel 4" onClick="orderParcel(4)"/>
                <aui:button href="<%= redirect %>" type="cancel" />
            </aui:button-row>
            <div class="table-style-stacked">
                <div class="table-responsive">
                    <table class="table table-autofit">
                        <thead>
                        <tr class="">
                            <th class="table-cell-expand-smaller">
                                <p class="table-list-title">SKU</p>
                            </th>
                            <th class="table-cell-expand-smaller">
                                <p class="table-list-title">Name</p>
                            </th>
                            <th class="table-cell-expand-smaller">
                                <p class="table-list-title">Order Multiples</p>
                            </th>
                            <th class="table-cell-expand-smaller">
                                <p class="table-list-title">Price</p>
                            </th>
                            <th class="table-cell-expand-smaller">

                            </th>
                        </tr>
                        </thead>
                        <%
                            for (CPCatalogEntry cpCatalogEntry : cpCatalogEntries) {
                        %>
                        <tr class="">
                            <%
                                String friendlyURL = cpContentHelper.getFriendlyURL(cpCatalogEntry, themeDisplay);
                                CPSku cpSku = cpContentHelper.getDefaultCPSku(cpCatalogEntry);
                                long cpDefinitionId = cpCatalogEntry.getCPDefinitionId();
                                CPDefinitionInventory cpDefinitionInventory =
                                        CPDefinitionInventoryLocalServiceUtil.
                                                fetchCPDefinitionInventoryByCPDefinitionId(cpDefinitionId);
                                int multipleOrderQuantity = cpDefinitionInventory.getMultipleOrderQuantity();

                                String skuValue;
                                long cpInstanceId = 0;


                                List<CPSku> cpSkus = cpCatalogEntry.getCPSkus();
                                String addToCartId = PortalUtil.generateRandomKey(request, "add-to-cart");

                                if (cpSkus.size() > 1){
                                    skuValue = "Multiple SKUs";
                                }else {
                                    skuValue = cpContentHelper.getDefaultCPSku(cpCatalogEntry).getSku();
                                    cpInstanceId = cpSkus.get(0).getCPInstanceId();
                                }

                            %>
                            <td class=""><a href="<%= friendlyURL %>"><%= skuValue %></a></td>
                            <td class=""><a href="<%= friendlyURL %>"><%= cpCatalogEntry.getName() %></a></td>
                            <td class=""><%= multipleOrderQuantity %></td>

                            <td class="">
                                <commerce-ui:price
                                        CPDefinitionId="<%= cpCatalogEntry.getCPDefinitionId() %>"
                                        CPInstanceId="<%= cpInstanceId %>"
                                />
                            </td>
                            <td id="<%=skuValue%>">
                                <commerce-ui:add-to-cart
                                                CPInstanceId="<%= cpSku.getCPInstanceId() %>"
                                                id="<%= addToCartId %>"
                                />
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </c:when>
    <c:otherwise>
        <div class="alert alert-info">
            <liferay-ui:message key="no-products-were-found" />
        </div>
    </c:otherwise>
</c:choose>

<script>
    function orderParcel(parcelNumber){
        switch (parcelNumber) {
            case 1:
                parcelQauntities = [
                    {
                        "sku":"FGD250SAIGO",
                        "quantity":"36"
                    },
                    {
                        "sku":"FGC060CYPRU",
                        "quantity":"24"
                    },
                    {
                        "sku":"FGC060AMAL",
                        "quantity":"48"
                    },
                    {
                        "sku":"FGD250AMALF",
                        "quantity":"48"
                    },
                    {
                        "sku":"FGC380AMALF",
                        "quantity":"48"
                    }
                ];
                break;
            case 2:
                parcelQauntities = [
                    {
                        "sku":"FGD250SAIGO",
                        "quantity":"28"
                    },
                    {
                        "sku":"FGC060CYPRU",
                        "quantity":"12"
                    },
                    {
                        "sku":"FGC060AMAL",
                        "quantity":"36"
                    },
                    {
                        "sku":"FGD250AMALF",
                        "quantity":"36"
                    },
                    {
                        "sku":"FGC380AMALF",
                        "quantity":"27"
                    }
                ];
                break;
            case 3:
                parcelQauntities = [
                    {
                        "sku":"FGD250SAIGO",
                        "quantity":"20"
                    },
                    {
                        "sku":"FGC060CYPRU",
                        "quantity":"8"
                    },
                    {
                        "sku":"FGC060AMAL",
                        "quantity":"28"
                    },
                    {
                        "sku":"FGD250AMALF",
                        "quantity":"24"
                    },
                    {
                        "sku":"FGC380AMALF",
                        "quantity":"18"
                    }
                ];
                break;
            case 4:
                parcelQauntities = [
                    {
                        "sku":"FGD250SAIGO",
                        "quantity":"12"
                    },
                    {
                        "sku":"FGC060CYPRU",
                        "quantity":"4"
                    },
                    {
                        "sku":"FGC060AMAL",
                        "quantity":"16"
                    },
                    {
                        "sku":"FGD250AMALF",
                        "quantity":"16"
                    },
                    {
                        "sku":"FGC380AMALF",
                        "quantity":"9"
                    }
                ];
                break;
        }


        parcelQauntities.forEach(function(obj) {
            const tableRow = document.getElementById(obj.sku);
            if (tableRow){
                tableRow.getElementsByTagName('input').quantity.value = obj.quantity;
            }
            // const quantityInput = tableRow.getElementsByTagName('input');
            // quantityInput.quantity.value = obj.quantity;
            // console.log(quantityInput.quantity.value);
            //
        });
    }
</script>
