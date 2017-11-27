From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 18/35] nds32: Debugging support
Date: Mon, 27 Nov 2017 15:34:57 +0100
Message-ID: <CAK8P3a2czU7=jECXFOvtRNhrq3zyX7gV7sa3OFPQ-8A4U8iH0A@mail.gmail.com>
References: <cover.1511785528.git.green.hu@gmail.com> <01fc485408504e6a43b768664f44b9fd42a89503.1511785528.git.green.hu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01fc485408504e6a43b768664f44b9fd42a89503.1511785528.git.green.hu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greentime Hu <green.hu@gmail.com>
Cc: Greentime <greentime@andestech.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Rob Herring <robh+dt@kernel.org>, Networking <netdev@vger.kernel.org>, Vincent Chen <deanbo422@gmail.com>, DTML <devicetree@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, David Howells <dhowells@redhat.com>, Will Deacon <will.deacon@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-serial@vger.kernel.org, Vincent Chen <vincentc@andestech.com>
List-Id: linux-arch.vger.kernel.org

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
