From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_BIG_ENDIAN
Date: Wed, 24 May 2017 11:48:44 +0200
Message-ID: <CAMuHMdV0fRdcbDWfafT0_cFSWikfgHghCJ+VkropPW_1wC7hRg@mail.gmail.com>
References: <1495575958-1022566-1-git-send-email-babu.moger@oracle.com> <1495575958-1022566-4-git-send-email-babu.moger@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mail-it0-f66.google.com ([209.85.214.66]:33743 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbdEXJsr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 24 May 2017 05:48:47 -0400
In-Reply-To: <1495575958-1022566-4-git-send-email-babu.moger@oracle.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Babu Moger <babu.moger@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, shannon.nelson@oracle.com, haakon.bugge@oracle.com, steven.sistare@oracle.com, vijay.ac.kumar@oracle.com, jane.chu@oracle.com, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>

On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com> wrote:
> Found this problem while enabling queued rwlock on SPARC.
> The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
> specific byte in qrwlock structure. Without this parameter,
> we clear the wrong byte. Here is the code.
>
> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>  {
>         return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>  }
>
> Define CPU_BIG_ENDIAN for SPARC to fix it.
>
> Signed-off-by: Babu Moger <babu.moger@oracle.com>
> Reviewed-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> Reviewed-by: Jane Chu <jane.chu@oracle.com>
> Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
> Reviewed-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
> ---
>  arch/sparc/Kconfig |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index 908f019..2f58c16 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -92,6 +92,10 @@ config ARCH_DEFCONFIG
>  config ARCH_PROC_KCORE_TEXT
>         def_bool y
>
> +config CPU_BIG_ENDIAN
> +       bool
> +       default y if SPARC

def_bool y?

Gr{oetje,eeting}s,

                        Geert
