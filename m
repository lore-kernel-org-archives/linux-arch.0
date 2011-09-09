From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 19/36] Hexagon: Add ptrace support
Date: Fri, 09 Sep 2011 10:15:22 +0200
Message-ID: <6788879.2Pf4OtZvAN@wuerfel>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.525482401@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110909010916.525482401@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 08 September 2011 20:09:06 Richard Kuo wrote:
> Will look at the more generic ptrace support in the future.
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>

Note that this absolutely has to be completed before the code is merged upstream,
because it is relevant to the ABI.

	Arnd
