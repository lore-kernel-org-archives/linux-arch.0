From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 20/29] nios2: Cpuinfo handling
Date: Tue, 15 Jul 2014 11:47:28 +0200
Message-ID: <7103938.6xzUh5tnai@wuerfel>
References: <1405413956-2772-1-git-send-email-lftan@altera.com> <1405413956-2772-21-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1405413956-2772-21-git-send-email-lftan@altera.com>
Sender: linux-doc-owner@vger.kernel.org
To: Ley Foon Tan <lftan@altera.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, lftan.linux@gmail.com, cltang@codesourcery.com
List-Id: linux-arch.vger.kernel.org

On Tuesday 15 July 2014 16:45:47 Ley Foon Tan wrote:
> +static void *cpuinfo_start(struct seq_file *m, loff_t *pos)
> +{
> +       unsigned long i = *pos;
> +
> +       return i < num_possible_cpus() ? (void *) (i + 1) : NULL;
> +}
> +
> +static void *cpuinfo_next(struct seq_file *m, void *v, loff_t *pos)
> +{
> +       ++*pos;
> +       return cpuinfo_start(m, pos);
> +}

Do you actually have SMP support?

> +const struct seq_operations cpuinfo_op = {
> +       .start  = cpuinfo_start,
> +       .next   = cpuinfo_next,
> +       .stop   = cpuinfo_stop,
> +       .show   = show_cpuinfo
> +};

If not, you can use single_start/next/stop here rather than defining your own.

	Arnd
