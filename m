From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: linux-next: Tree for Jun 21
Date: Tue, 21 Jun 2016 21:04:12 +0200
Message-ID: <20160621190412.GU30927@twins.programming.kicks-ass.net>
References: <20160621124247.GM30921@twins.programming.kicks-ass.net>
 <5ed77f4c-44eb-ca02-1373-e878d3dea31e@mellanox.com>
 <20160621140408.GE3704@worktop>
 <20160621141435.GB7381@worktop>
 <94270f5c-1a28-f9d7-2b5a-eb874dc35398@mellanox.com>
 <20160621170607.GQ30154@twins.programming.kicks-ass.net>
 <20160621172918.GS30927@twins.programming.kicks-ass.net>
 <20160621182844.GT30927@twins.programming.kicks-ass.net>
 <ff97cde6-44e2-e25d-7bd2-78dbf344fc7b@mellanox.com>
 <20160621185048.GR30909@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160621185048.GR30909@twins.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, Jun 21, 2016 at 08:50:48PM +0200, Peter Zijlstra wrote:
> I've no idea; I use this thing:
> 
>   git://git.infradead.org/users/segher/buildall.git
> 
> Although I've got some local modifications, none are to the actual
> toolchain building part (although I suppose I should send segher a
> patch).

Oops, I do have..

sjlj-exceptions is causing aarch64 to fail, so I killed it, its not like
the kernel needs that.


diff --git a/build-gcc b/build-gcc
index a93c624..183f445 100755
--- a/build-gcc
+++ b/build-gcc
@@ -22,7 +22,7 @@ $ECHO -ne "       gcc:" && \
 	$GCC_SRC/configure \
 	--target=$TARGET --enable-targets=all --prefix=$PREFIX \
 	--enable-languages=c --without-headers --disable-bootstrap \
-	--enable-sjlj-exceptions --with-system-libunwind \
+	--disable-sjlj-exceptions --with-system-libunwind \
 	--disable-nls --disable-threads --disable-shared \
 	--disable-libmudflap --disable-libssp --disable-libgomp \
 	--disable-decimal-float --disable-libquadmath \
