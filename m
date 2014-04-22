From: Jesper Nilsson <jesper.nilsson@axis.com>
Subject: Re: [PATCH 07/18] cris: io: implement dummy relaxed accessor
 macros for writes
Date: Tue, 22 Apr 2014 15:47:30 +0200
Message-ID: <20140422134730.GS32241@axis.com>
References: <1397742261-15621-1-git-send-email-will.deacon@arm.com>
 <1397742261-15621-8-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1397742261-15621-8-git-send-email-will.deacon@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de, monstr@monstr.eu, dhowells@redhat.com, broonie@linaro.org, benh@kernel.crashing.org, peterz@infradead.org, paulmck@linux.vnet.ibm.com, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jespern@axis.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Apr 17, 2014 at 02:44:10PM +0100, Will Deacon wrote:
> write{b,w,l}_relaxed are implemented by some architectures in order to
> permit memory-mapped I/O accesses with weaker barrier semantics than the
> non-relaxed variants.
> 
> This patch adds dummy macros for the write accessors to Cris, in the same
> vein as the dummy definitions for the relaxed read accessors.
> 
> Cc: Mikael Starvik <starvik@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Signed-off-by: Will Deacon <will.deacon@arm.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
