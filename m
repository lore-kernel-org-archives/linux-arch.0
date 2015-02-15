From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH v3 05/15] h8300: Process and signal
Date: Sun, 15 Feb 2015 11:33:25 +0100
Message-ID: <1423996405.9418.62.camel@x220>
References: <1423986573-2329-1-git-send-email-ysato@users.sourceforge.jp>
	 <1423986573-2329-6-git-send-email-ysato@users.sourceforge.jp>
	 <871tlrr3um.wl-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <871tlrr3um.wl-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

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
