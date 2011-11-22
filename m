From: David Daney <ddaney.cavm@gmail.com>
Subject: Re: [PATCH RFC 3/5] kbuild/extable: Hook up sortextable into the
 build system.
Date: Tue, 22 Nov 2011 13:38:37 -0800
Message-ID: <4ECC165D.60300@gmail.com>
References: <1321645068-20475-1-git-send-email-ddaney.cavm@gmail.com> <1321645068-20475-4-git-send-email-ddaney.cavm@gmail.com> <4EC9046C.3050708@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:34974 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757481Ab1KVVil (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Tue, 22 Nov 2011 16:38:41 -0500
In-Reply-To: <4EC9046C.3050708@suse.cz>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Michal Marek <mmarek@suse.cz>
Cc: David Daney <ddaney.cavm@gmail.com>, "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, "ralf@linux-mips.org" <ralf@linux-mips.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "linux-embedded@vger.kernel.org" <linux-embedded@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, David Daney <david.daney@cavium.com>

On 11/20/2011 05:45 AM, Michal Marek wrote:
> On 18.11.2011 20:37, David Daney wrote:
>> +	$(if $(CONFIG_BUILDTIME_EXTABLE_SORT),				\
>> +	$(Q)$(if $($(quiet)cmd_sortextable),				\
>> +	  echo '  $($(quiet)cmd_sortextable)  vmlinux'&&)		\
>> +	  $(cmd_sortextable)  vmlinux)
>
> Why do you opencode $(call cmd,sortextable) here?
>

Mostly just mimicking the other code in the vicinity.

I will try to improve it in the next version of the patch.

Thanks,
David Daney
