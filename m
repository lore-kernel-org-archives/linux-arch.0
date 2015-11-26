From: "PaX Team" <pageexec@freemail.hu>
Subject: Re: [PATCH v2 1/4] init: create cmdline param to disable readonly
Date: Thu, 26 Nov 2015 01:37:51 +0100
Message-ID: <5656545F.29919.10A1CE2B@pageexec.freemail.hu>
References: <1448494286-16029-1-git-send-email-keescook@chromium.org>, <1448494286-16029-2-git-send-email-keescook@chromium.org>
Reply-To: kernel-hardening@lists.openwall.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <kernel-hardening-return-1978-glkh-kernel-hardening=m.gmane.org@lists.openwall.com>
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
In-reply-to: <1448494286-16029-2-git-send-email-keescook@chromium.org>
Content-description: Mail message body
To: linux-kernel@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>, Andy Lutomirski <luto@amacapital.net>, "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, Mathias Krause <minipli@googlemail.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Emese Revfy <re.emese@gmail.com>, kernel-hardening@lists.openwall.com, linux-arch <linux-arch@vger.kernel.org>
List-Id: linux-arch.vger.kernel.org

On 25 Nov 2015 at 15:31, Kees Cook wrote:

> +	rodata=		[KNL]
> +		on	Mark read-only kernel memory as read-only (default).
> +		off	Leave read-only kernel memory writable for debugging.
> +

> +#ifdef CONFIG_DEBUG_RODATA
> +bool disable_mark_readonly;

__initdata?

> +static int __init set_debug_rodata(char *str)
> +{
> +	if (!str)
> +		return -EINVAL;
> +	if (!strncmp(str, "on", 2))
> +		disable_mark_readonly = false;
> +	else if (!strncmp(str, "off", 3))
> +		disable_mark_readonly = true;

maybe it's just me but the double negatives make my head spin,
perhaps call it enable_rodata instead (so that the variable name
isn't so disconnected from the option name)?

> +
> +	return 0;
> +}
> +__setup("rodata=", set_debug_rodata);
> +
> +static void mark_readonly(void)
> +{
> +	if (disable_mark_readonly)
> +		pr_info("Kernel read-only memory marking disabled.\n");
> +	else
> +		mark_rodata_ro();
> +}
