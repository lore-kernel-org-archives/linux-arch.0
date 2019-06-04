From: Christoph Hellwig <hch@lst.de>
Subject: Re: remove asm-generic/ptrace.h v2
Date: Tue, 4 Jun 2019 09:02:05 +0200
Message-ID: <20190604070205.GA15438@lst.de>
References: <20190520060018.25569-1-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190520060018.25569-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleg Nesterov <oleg@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

Is anyone going to pick this series up?

On Mon, May 20, 2019 at 08:00:13AM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> asm-generic/ptrace.h is a little weird in that it doesn't actually
> implement any functionality, but it provided multiple layers of macros
> that just implement trivial inline functions.  We implement those
> directly in the few architectures and be off with a much simpler
> design.
> 
> Changes since v1:
>  - add a missing empty line between functions
---end quoted text---
