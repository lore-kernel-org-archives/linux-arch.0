From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 17/24] C6X: ptrace support
Date: Mon, 22 Aug 2011 23:07:44 +0200
Message-ID: <1592466.ajYVm6FHSj@wuerfel>
References: <1314043785-2880-1-git-send-email-msalter@redhat.com> <1314043785-2880-18-git-send-email-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:57146 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab1HVVIQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 22 Aug 2011 17:08:16 -0400
In-Reply-To: <1314043785-2880-18-git-send-email-msalter@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-arch@vger.kernel.org

On Monday 22 August 2011 16:09:38 Mark Salter wrote:
> +               /*
> +                * get all gp regs from the child.
> +                */
> +       case PTRACE_GETREGS:
> +               return copy_regset_to_user(child, &user_c6x_native_view,
> +                                          REGSET_GPR,
> +                                          0, NR_PTREGS * sizeof(long),
> +                                          datap);
> +
> +               /*
> +                * set all gp regs in the child.
> +                */
> +       case PTRACE_SETREGS:
> +               return copy_regset_from_user(child, &user_c6x_native_view,
> +                                            REGSET_GPR,
> +                                            0, NR_PTREGS * sizeof(long),
> +                                            datap);
> +
> +       default:
> +               ret = ptrace_request(child, request, addr, data);
> +               break;

I noticed that you removed PTRACE_PEEKUSR and PTRACE_POKEUSR, and I also
noticed that you need special handling for PTRACE_POKETEXT. What about
PTRACE_GETREGS/PTRACE_SETREGS? Can the generic ptrace_request take care
of these as well? It seems to be the case on arch/openrisc.

	Arnd
