From: Michal Marek <mmarek@suse.com>
Subject: Re: [PATCH 3/6] kbuild: add arch specific post-link pass
Date: Wed, 17 Aug 2016 11:05:02 +0200
Message-ID: <b1f1106e-c09f-0333-919e-398c72117622@suse.com>
References: <1470910580-18458-1-git-send-email-npiggin@gmail.com>
 <1470910580-18458-4-git-send-email-npiggin@gmail.com>
 <57B2DBA1.6090304@suse.com> <20160817144322.4067391f@roar.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36517 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750787AbcHQJFG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 17 Aug 2016 05:05:06 -0400
In-Reply-To: <20160817144322.4067391f@roar.ozlabs.ibm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, Nicolas Pitre <nico@linaro.org>, Segher Boessenkool <segher@kernel.crashing.org>, Alan Modra <amodra@gmail.com>

On 2016-08-17 06:43, Nicholas Piggin wrote:
> On Tue, 16 Aug 2016 11:23:45 +0200
> Michal Marek <mmarek@suse.com> wrote:
> 
>> Dne 11.8.2016 v 12:16 Nicholas Piggin napsal(a):
>>>  $(modules): %.ko :%.o %.mod.o FORCE
>>>  	$(call if_changed,ld_ko_o)
>>> +ifdef CONFIG_BUILD_ARCH_POSTLINK
>>> +	$(Q)$(MAKE) -f $(srctree)/arch/$(SRCARCH)/Makefile.postlink $@
>>> +endif  
>>
>> Why not simply branch off the existence of arch/*/Makefile.postlink and
>> drop the kconfig option?
> 
> I just did not think of it. That does seem nicer, thanks. What do
> you think of this?
[...]

This looks cleaner, thanks!

Michal
