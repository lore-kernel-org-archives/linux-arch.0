From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 16/31] arm64: ELF definitions
Date: Wed, 15 Aug 2012 14:15:39 +0000
Message-ID: <201208151415.39570.arnd@arndb.de>
References: <1344966752-16102-1-git-send-email-catalin.marinas@arm.com> <1344966752-16102-17-git-send-email-catalin.marinas@arm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:58455 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479Ab2HOOPo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 15 Aug 2012 10:15:44 -0400
In-Reply-To: <1344966752-16102-17-git-send-email-catalin.marinas@arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Will Deacon <will.deacon@arm.com>

On Tuesday 14 August 2012, Catalin Marinas wrote:
> +
> +void elf_set_personality(int personality)
> +{
> +       switch (personality & PER_MASK) {
> +       case PER_LINUX:
> +               clear_thread_flag(TIF_32BIT);
> +               break;
> +       case PER_LINUX32:
> +               set_thread_flag(TIF_32BIT);
> +               break;
> +       default:
> +               pr_warning("Process %s tried to assume unknown personality %d\n",
> +                          current->comm, personality);
> +               return;
> +       }
> +
> +       current->personality = personality;
> +}
> +EXPORT_SYMBOL(elf_set_personality);

This looks wrong: PER_LINUX/PER_LINUX32 decides over the output of the
uname system call, while TIF_32BIT decides over the instruction set
when returning to user space. You definitely should not set the personality
to the value you pass from the elf loader. Instead, just do

#define SET_PERSONALITY(ex) clear_thread_flag(TIF_32BIT);
#defined COMPAT_SET_PERSONALITY(ex) set_thread_flag(TIF_32BIT);

I also don't see a reason to export this. You'd have trouble loading
the elf interpreter module from user space without the elf interpreter.

	Arnd
