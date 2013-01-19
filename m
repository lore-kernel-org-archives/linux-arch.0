From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 48/76] ARC: Module support
Date: Sat, 19 Jan 2013 17:26:36 +0530
Message-ID: <50FA89F4.9090203@synopsys.com>
References: <1358511930-7424-1-git-send-email-vgupta@synopsys.com> <1358511930-7424-49-git-send-email-vgupta@synopsys.com> <201301181450.33444.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:47982 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751909Ab3ASL5s (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Sat, 19 Jan 2013 06:57:48 -0500
In-Reply-To: <201301181450.33444.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday 18 January 2013 08:20 PM, Arnd Bergmann wrote:
> On Friday 18 January 2013, Vineet Gupta wrote:
>
>> +int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
>> +			      char *secstr, struct module *mod)
>> +{
>> +    return 0;
>> +}
>> +
>> +void module_arch_cleanup(struct module *mod)
>> +{
>> +}
>> +
>> +int module_finalize(const Elf32_Ehdr *hdr, const Elf_Shdr *sechdrs,
>> +		    struct module *mod)
>> +{
>> +    return 0;
>> +}
> These three empty functions are already defined __weak in kernel/module.c
> so you can simply omit them here.
>
> 	Arnd

Actually a subsequent patch to do dwarf unwinding out of modules has valid code in
those. But yes I can take them out from this patch and introduce in the the one
which really needs it.

Thx,
-Vineet
