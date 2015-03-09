From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH v6 06/16] h8300: CPU depend helpers
Date: Mon, 09 Mar 2015 09:21:07 -0700
Message-ID: <1425918067.5428.10.camel@perches.com>
References: <1425890830-29399-1-git-send-email-ysato@users.sourceforge.jp>
	 <1425890830-29399-7-git-send-email-ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425890830-29399-7-git-send-email-ysato@users.sourceforge.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Mon, 2015-03-09 at 17:47 +0900, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>

trivia:

>  arch/h8300/kernel/cpu/h83069/setup.c   | 202 ++++++++++++++++++++++++++
[]
> diff --git a/arch/h8300/kernel/cpu/h83069/setup.c b/arch/h8300/kernel/cpu/h83069/setup.c
[]
> +static struct resource sci0_resources[] = {
> +	DEFINE_RES_MEM(0xffffb0, 8),
> +	DEFINE_RES_IRQ(52),
> +	DEFINE_RES_IRQ(53),
> +	DEFINE_RES_IRQ(54),
> +	DEFINE_RES_IRQ(55),
> +}

Perhaps most all of these might be const?

> +static struct plat_sci_port sci0_platform_data = {
[]
> +static struct resource sci1_resources[] = {
[]
> +static struct plat_sci_port sci1_platform_data = {
[]
> +static struct platform_device sci0_device = {
[]
> +static struct platform_device sci1_device = {
[]
> +static struct h8300_timer8_config tm8_unit0_platform_data = {
[]
> +static struct resource tm8_unit0_resources[] = {
[]
> +static struct platform_device timer8_unit0_device = {
[]
> +static struct h8300_timer8_config tm8_unit1_platform_data = {
[]

etc..
