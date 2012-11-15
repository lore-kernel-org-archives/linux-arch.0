From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [RFC Patch v1 37/55] ARC: dynamic loadable module support
Date: Thu, 15 Nov 2012 15:58:55 +0530
Message-ID: <50A4C3E7.8020304@synopsys.com>
References: <1352720953-24321-1-git-send-email-vgupta@synopsys.com> <1352720953-24321-7-git-send-email-vgupta@synopsys.com> <201211121353.15314.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from vaxjo.synopsys.com ([198.182.60.75]:35295 "EHLO
	vaxjo.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992442Ab2KOKaC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 15 Nov 2012 05:30:02 -0500
In-Reply-To: <201211121353.15314.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de

On Monday 12 November 2012 07:23 PM, Arnd Bergmann wrote:
> On Monday 12 November 2012, Vineet.Gupta1@synopsys.com wrote:
>> +void *module_alloc(unsigned long size)
>> +{
>> +       if (size == 0)
>> +               return NULL;
>> +
>> +       return vmalloc(size);
>> +
>> +}
>> +
>> +void module_free(struct module *module, void *region)
>> +{
>> +       vfree(region);
>> +}
>> +
>> +int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
>> +                             char *secstr, struct module *mod)
>> +{
>> +    return 0;
>> +}
>> +
>> +void module_arch_cleanup(struct module *mod)
>> +{
>> +}
>> +
>> +int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>> +                   struct module *mod)
>> +{
>> +    return 0;
>> +} 
> All of these are identical to the default implementation in kernel/module.c
> and you can simply drop your own definitions.

Alloc/free dropped. Rest 3 needed for ARC specific unwinding out of
loadable modules.

>
> 	Arnd
