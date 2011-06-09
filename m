From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] unicore32: fix build error for find bitops
Date: Thu, 9 Jun 2011 20:32:40 +0900
Message-ID: <BANLkTikNC8uh-X_0iJZH3tYd_kf46W1Rwg@mail.gmail.com>
References: <1307617752-23426-1-git-send-email-gxt@mprc.pku.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:37028 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756180Ab1FILcl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 9 Jun 2011 07:32:41 -0400
In-Reply-To: <1307617752-23426-1-git-send-email-gxt@mprc.pku.edu.cn>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: GuanXuetao <gxt@mprc.pku.edu.cn>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, greg@kroah.com

2011/6/9 GuanXuetao <gxt@mprc.pku.edu.cn>:
> From: Guan Xuetao <gxt@mprc.pku.edu.cn>
>
> Remove the __uc32_ prefix in find bitops functions.
> see commit <19de85ef574c3a2182e3ccad9581805052f14946>
> =A0bitops: add #ifndef for each of find bitops
>
> Signed-off-by: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> ---
> =A0arch/unicore32/include/asm/bitops.h | =A0 =A06 ------
> =A0arch/unicore32/kernel/ksyms.c =A0 =A0 =A0 | =A0 =A04 ++--
> =A0arch/unicore32/lib/findbit.S =A0 =A0 =A0 =A0| =A0 14 ++++++++-----=
-
> =A03 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/arch/unicore32/include/asm/bitops.h b/arch/unicore32/inc=
lude/asm/bitops.h
> index 1628a63..a9653f0 100644
> --- a/arch/unicore32/include/asm/bitops.h
> +++ b/arch/unicore32/include/asm/bitops.h
> @@ -13,12 +13,6 @@
> =A0#ifndef __UNICORE_BITOPS_H__
> =A0#define __UNICORE_BITOPS_H__
>
> -#define find_next_bit =A0 =A0 =A0 =A0 =A0__uc32_find_next_bit
> -#define find_next_zero_bit =A0 =A0 __uc32_find_next_zero_bit
> -
> -#define find_first_bit =A0 =A0 =A0 =A0 __uc32_find_first_bit
> -#define find_first_zero_bit =A0 =A0__uc32_find_first_zero_bit
> -

Is this patch really fix the build error?

If these find_*_bit macros are removed, vmlinux will have multiple
definisions of find_*_bit. Because lib/find_next_bit.c is built
unconditionally after the commit 63e424c84429903c92a0f1e9654c31ccaf6694=
d0
("arch: remove CONFIG_GENERIC_FIND_{NEXT_BIT,BIT_LE,LAST_BIT}".
