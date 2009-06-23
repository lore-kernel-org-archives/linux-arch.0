From: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH] PCI: remove pcibios_scan_all_fns()
Date: Tue, 23 Jun 2009 21:29:40 +0300
Message-ID: <4A411F14.1080406@redhat.com>
References: <20090622140807.25509.54448.stgit@bob.kio> <20090622143431.GT19977@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:39315 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755370AbZFWSbK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 23 Jun 2009 14:31:10 -0400
In-Reply-To: <20090622143431.GT19977@parisc-linux.org>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Alex Chiang <achiang@hp.com>, jbarnes@virtuousgeek.org, linux-arch@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>, Tony Luck <tony.luck@intel.com>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Ingo Molnar <mingo@redhat.com>, "David S. Miller" <davem@davemloft.net>

On 06/22/2009 05:34 PM, Matthew Wilcox wrote:
>
>> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
>> index f1ae247..b613cad 100644
>> --- a/drivers/pci/probe.c
>> +++ b/drivers/pci/probe.c
>> @@ -1056,8 +1056,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>>   	if (dev&&  !dev->is_added)	/* new device? */
>>   		nr++;
>>
>> -	if ((dev&&  dev->multifunction) ||
>> -	    (!dev&&  pcibios_scan_all_fns(bus, devfn))) {
>> +	if (dev&&  dev->multifunction) {
>>   		for (fn = 1; fn<  8; fn++) {
>>   			dev = pci_scan_single_device(bus, devfn + fn);
>>   			if (dev) {
>>      
>
> What a good idea.  I was just looking at making this more complicated
> (due to the ARI capability).
>
> I'd like to know what the KVM / Xen / ... people think about this.
> I don't know if they rely on function 5 being able to show up out of
> the blue.
>
>    

You mean have a function 5 without a function 0?  This doesn't impact 
kvm at all.

Moreover, I see pcibios_scan_all_fns() uniformly defined as 0, so this 
patch doesn't change much, does it?

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
