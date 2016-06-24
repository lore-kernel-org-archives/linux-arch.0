From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH V2 63/63] clocksources: Switch back to the clksrc table
Date: Fri, 24 Jun 2016 15:13:20 +0800
Message-ID: <CAGb2v64Qk822h2Mqp1Moc1yV7uXSEQBGiurkyFLSZdJ6NOO3Vg@mail.gmail.com>
References: <1466112442-31105-1-git-send-email-daniel.lezcano@linaro.org> <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1466112442-31105-64-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel <linux-kernel@vger.kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Russell King <linux@armlinux.org.uk>, Michal Simek <monstr@monstr.eu>, John Crispin <john@phrozen.org>, Ralf Baechle <ralf@linux-mips.org>, Ley Foon Tan <lftan@altera.com>, Srinivas Kandagatla <srinivas.kandagatla@gmail.com>, Maxime Coquelin <maxime.coquelin@st.com>, Patrice Chotard <patrice.chotard@st.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, =?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann@xilinx.com>, Linus Walleij <linus.walleij@linaro.org>, Alexander
List-Id: linux-arch.vger.kernel.org

On Fri, Jun 17, 2016 at 5:27 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> All the clocksource drivers's init function are now converted to return
> an error code. CLOCKSOURCE_OF_DECLARE is no longer used as well as the
> clksrc-of table.
>
> Let's convert back the names:
>  - CLOCKSOURCE_OF_DECLARE_RET => CLOCKSOURCE_OF_DECLARE
>  - clksrc-of-ret              => clksrc-of
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/clocksource/sun4i_timer.c         |  2 +-
>  drivers/clocksource/timer-sun5i.c         |  4 ++--

Acked-by: Chen-Yu Tsai <wens@csie.org>
