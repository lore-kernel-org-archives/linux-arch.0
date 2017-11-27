Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mail-ot0-f196.google.com ([74.125.82.196]:37257 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752264AbdK0Oe7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Nov 2017 09:34:59 -0500
MIME-Version: 1.0
In-Reply-To: <01fc485408504e6a43b768664f44b9fd42a89503.1511785528.git.green.hu@gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <01fc485408504e6a43b768664f44b9fd42a89503.1511785528.git.green.hu@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 27 Nov 2017 15:34:57 +0100
Message-ID: <CAK8P3a2czU7=jECXFOvtRNhrq3zyX7gV7sa3OFPQ-8A4U8iH0A@mail.gmail.com>
Subject: Re: [PATCH v2 18/35] nds32: Debugging support
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
Message-ID: <20171127143457.Ylj01hJo1HggVMpbqAKjOwv5Kd8YnLSJlcz1ZNZLqgc@z>

On Mon, Nov 27, 2017 at 1:28 PM, Greentime Hu <green.hu@gmail.com> wrote:
> +struct user_pt_regs {
> +       long uregs[26];
> +       long fp;
> +       long gp;
> +       long lp;
> +       long sp;
> +       long ipc;
> +#if defined(CONFIG_HWZOL)
> +       long lb;
> +       long le;
> +       long lc;
> +#else
> +       long dummy[3];
> +#endif
> +       long syscallno;
> +};

You cannot reference CONFIG_ symbols in a uapi header, since the
configuration headers
are not available.

       Arnd
