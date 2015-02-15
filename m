Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:57406 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754578AbbBOKd2 (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Sun, 15 Feb 2015 05:33:28 -0500
Message-ID: <1423996405.9418.62.camel@x220>
Subject: Re: [PATCH v3 05/15] h8300: Process and signal
From: Paul Bolle <pebolle@tiscali.nl>
Date: Sun, 15 Feb 2015 11:33:25 +0100
In-Reply-To: <871tlrr3um.wl-ysato@users.sourceforge.jp>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
	 <1423986573-2329-6-git-send-email-ysato@users.sourceforge.jp>
	 <871tlrr3um.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Message-ID: <20150215103325.49M6PrVI52soRI36ErgQfJsM-XRbqfJNNku2CN4K4MY@z>

On Sun, 2015-02-15 at 17:11 +0900, Yoshinori Sato wrote:
> Sorry. I send too old files.
> This patch is correct.
> 
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/h8300/kernel/process.c | 170 +++++++++++++++++++++++
>  arch/h8300/kernel/ptrace.c  | 203 +++++++++++++++++++++++++++
>  arch/h8300/kernel/signal.c  | 326 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 699 insertions(+)
>  create mode 100644 arch/h8300/kernel/process.c
>  create mode 100644 arch/h8300/kernel/ptrace.c
>  create mode 100644 arch/h8300/kernel/signal.c
> 
>[...]
> diff --git a/arch/h8300/kernel/signal.c b/arch/h8300/kernel/signal.c
> new file mode 100644
> index 0000000..1222783
> --- /dev/null
> +++ b/arch/h8300/kernel/signal.c
> @@ -0,1 +1,326 @@

That line should read
    @@ -0,0 +1,326 @@

shouldn't it? At least, currently that line makes "git am" here barf
with
    fatal: new file arch/h8300/kernel/signal.c depends on old contents


Paul Bolle

