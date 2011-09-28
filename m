Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62364 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754315Ab1I1N5u (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 28 Sep 2011 09:57:50 -0400
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 18/24] C6X: ptrace support
Date: Wed, 28 Sep 2011 15:57:47 +0200
References: <1317155405-26235-1-git-send-email-msalter@redhat.com> <1317155405-26235-19-git-send-email-msalter@redhat.com>
In-Reply-To: <1317155405-26235-19-git-send-email-msalter@redhat.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-ID: <201109281557.47986.arnd@arndb.de>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Mark Salter <msalter@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20110928135747.9L33bv_Cosf7VGn8rVkxP8UYjlPBYvStJPzSeieiqaE@z>

On Tuesday 27 September 2011, Mark Salter wrote:
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

I believe that you can let this be handled by the common 
ptrace_request() function if you provide the necessary code for
setting CONFIG_HAVE_ARCH_TRACEHOOK, which is preferred now.

	Arnd
