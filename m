From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch v3 24/36] Hexagon: Provide basic implementation and/or stubs for I/O routines.
Date: Fri, 09 Sep 2011 10:18:09 +0200
Message-ID: <1604210.HF5P4V98ih@wuerfel>
References: <20110909010847.294039464@codeaurora.org> <20110909010916.993872033@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-hexagon-owner@vger.kernel.org>
In-Reply-To: <20110909010916.993872033@codeaurora.org>
Sender: linux-hexagon-owner@vger.kernel.org
To: Richard Kuo <rkuo@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, Linas Vepstas <linas@codeaurora.org>
List-Id: linux-arch.vger.kernel.org

On Thursday 08 September 2011 20:09:11 Richard Kuo wrote:
> Filled in the ins/outs; leaving them in for now.
> 
> Change _IO_BASE and IO_SPACE_LIMIT for safety.
> 
> I have compiled this with sparse and it builds; I've also picked over
> various files related to the HAS_IOPORT_MAP from arm-soc.git and
> tried them out, and they work, so I guess we'll just wait until
> they're merged.
> 
> 
> Signed-off-by: Richard Kuo <rkuo@codeaurora.org>
> Signed-off-by: Linas Vepstas <linas@codeaurora.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
