From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 20/25] sparc: Use Kbuild infrastructure to handle
 asm-generic headers
Date: Fri, 12 Oct 2012 23:19:41 -0400 (EDT)
Message-ID: <20121012.231941.1930318153077157651.davem@davemloft.net>
References: <20121013022632.024527228@goodmis.org>
	<20121013022955.307620438@goodmis.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121013022955.307620438@goodmis.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

From: Steven Rostedt <rostedt@goodmis.org>
Date: Fri, 12 Oct 2012 22:26:52 -0400

> From: Steven Rostedt <srostedt@redhat.com>
> 
> Use Kbuild infrastructure to handle the asm-generic headers
> and remove the wrapper headers that call them.
> 
> This only affects headers that do nothing but include the generic
> equivalent. It does not touch any header that does a little more.
> 
> Cc: linux-kbuild@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: "David S. Miller" <davem@davemloft.net>
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Acked-by: David S. Miller <davem@davemloft.net>
