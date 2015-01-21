From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 13/16] h8300: ptrace helper
Date: Wed, 21 Jan 2015 09:51:34 +0100
Message-ID: <2669606.8TdqsMIDS0@wuerfel>
References: <cover.1421813622.git.ysato@users.sourceforge.jp> <87h9vkvjnw.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:60742 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832AbbAUIvo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 21 Jan 2015 03:51:44 -0500
In-Reply-To: <87h9vkvjnw.wl-ysato@users.sourceforge.jp>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-arch@vger.kernel.org

On Wednesday 21 January 2015 13:31:47 Yoshinori Sato wrote:

> +long arch_ptrace(struct task_struct *child, long request,
> +		 unsigned long addr, unsigned long data)
> +{
> +	int ret;
> +	int regno = addr >> 2;
> +	unsigned long __user *datap = (unsigned long __user *) data;
> +
> +	switch (request) {
> +	/* read the word at location addr in the USER area. */
> +	case PTRACE_PEEKUSR: {
...
> +	case PTRACE_POKEUSR: /* write the word at location addr
...
> +	case PTRACE_GETREGS: { /* Get all gp regs from the child. */
...
> +	case PTRACE_SETREGS: { /* Set all gp regs in the child. */

For modern architecture implementations, we now use 'regset' to
abstract these, and simplify the arch_ptrace interface to
a single ptrace_request call. See openrisc or arm64 as examples.

	Arnd
