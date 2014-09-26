From: Ley Foon Tan <lftan@altera.com>
Subject: Re: [PATCH v3 28/29] Documentation: Add documentation for Nios2 architecture
Date: Fri, 26 Sep 2014 10:27:32 +0800
Message-ID: <CAFiDJ5_J0a0OWkX6FV=Gqz6J6BWcyYYOvZyAS9oRqvMaq4Nftw@mail.gmail.com>
References: <1410168160-3624-1-git-send-email-lftan@altera.com>
	<1410168160-3624-29-git-send-email-lftan@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1410168160-3624-29-git-send-email-lftan@altera.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-Arch <linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Cc: Ley Foon Tan <lftan@altera.com>, LeyFoon Tan <lftan.linux@gmail.com>, Chung-Lin Tang <cltang@codesourcery.com>, rdunlap@infradead.org
List-Id: linux-arch.vger.kernel.org

On Mon, Sep 8, 2014 at 5:22 PM, Ley Foon Tan <lftan@altera.com> wrote:
> Signed-off-by: Ley Foon Tan <lftan@altera.com>
> ---
>  Documentation/nios2/README | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
>  create mode 100644 Documentation/nios2/README
>
> diff --git a/Documentation/nios2/README b/Documentation/nios2/README
> new file mode 100644
> index 0000000..054a67d
> --- /dev/null
> +++ b/Documentation/nios2/README
> @@ -0,0 +1,23 @@
> +Linux on the Nios II architecture
> +=================================
> +
> +This is a port of Linux to Nios II (nios2) processor.
> +
> +In order to compile for Nios II, you need a version of GCC with support for the generic
> +system call ABI. Please see this link for more information on how compiling and booting
> +software for the Nios II platform:
> +http://www.rocketboards.org/foswiki/Documentation/NiosIILinuxUserManual
> +
> +For reference, please see the following link:
> +http://www.altera.com/literature/lit-nio2.jsp
> +
> +What is Nios II?
> +================
> +Nios II is a 32-bit embedded-processor architecture designed specifically for the
> +Altera family of FPGAs. In order to support Linux, Nios II needs to be configured
> +with MMU and hardware multiplier enabled.
> +
> +Nios II ABI
> +===========
> +Please refer to chapter "Application Binary Interface" in Nios II Processor Reference
> +Handbook.
> --
> 1.8.2.1
>

Add Randy to CC list.
