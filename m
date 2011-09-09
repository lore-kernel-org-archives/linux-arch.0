From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 08/36] Hexagon: Add delay functions
Date: Fri, 09 Sep 2011 10:07:05 +0200
Message-ID: <7440179.BsgeraFyS5@wuerfel>
References: <20110909010847.294039464@codeaurora.org> <20110909010915.450346603@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110909010915.450346603@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Thursday 08 September 2011 20:08:55 Richard Kuo wrote:
> Added read_current_timer elsewhere.
> 
> udelay is based off of __vmgettime() which returns processor ticks.
> 
> Removed __delay and CONFIG_GENERIC_CALIBRATE_DELAY.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
