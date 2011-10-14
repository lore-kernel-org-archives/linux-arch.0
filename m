From: Yinghai Lu <yinghai.lu@oracle.com>
Subject: Re: [PATCH v2 06/29] x86/PCI: convert to pci_create_root_bus() and
 pci_scan_root_bus()
Date: Fri, 14 Oct 2011 13:39:35 -0700
Message-ID: <4E989E07.6030404@oracle.com>
References: <20111014042142.23504.70417.stgit@bhelgaas.mtv.corp.google.com> <20111014042737.23504.46601.stgit@bhelgaas.mtv.corp.google.com> <4E97C8F0.7030108@oracle.com> <CAErSpo568q-KOk25RaaZ+=erLEEC4rsPwGNy0drCbqpCLKGybQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:52330 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756813Ab1JNUjt (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Fri, 14 Oct 2011 16:39:49 -0400
In-Reply-To: <CAErSpo568q-KOk25RaaZ+=erLEEC4rsPwGNy0drCbqpCLKGybQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>

On 10/14/2011 01:32 PM, Bjorn Helgaas wrote:


>>>       int node;
>>> @@ -353,11 +349,18 @@ struct pci_bus * __devinit pci_acpi_scan_root(struct acpi_pci_root *root)
>>>               memcpy(bus->sysdata, sd, sizeof(*sd));
>>>               kfree(sd);
>>>       } else {
>>> -             bus = pci_create_bus(NULL, busnum, &pci_root_ops, sd);
>>> -             if (bus) {
>>> -                     get_current_resources(device, busnum, domain, bus);
>>> -                     bus->subordinate = pci_scan_child_bus(bus);
>>> +             INIT_LIST_HEAD(&resources);
>>> +             get_current_resources(device, busnum, domain, &resources);
>>> +             if (!pci_use_crs) {
>>> +                     pci_free_resource_list(&resources);
>>> +                     x86_pci_root_bus_resources(busnum, &resources);
>>>               }
>>
>>
>> You may need to update get_current_resources() to return status about handling _CRS...
>> and check that status insteaf of !pci_use_crs.
> 
> Is the current patch broken here?  I don't think it will be simpler to
> have get_current_resources() return a status and check that.  But if
> something's actually broken, I want to fix it, of course.
> 


yes. if for some reason, _CRS is not handled right, that root bus resources will not get set to default res.

+             status = get_current_resources(device, busnum, domain, &resources);
+             if (status) {
+                     pci_free_resource_list(&resources);
+                     x86_pci_root_bus_resources(busnum, &resources);
              }

get_current_resources() will not return 0 if _CRS is not really used.

Thanks

	Yinghai
