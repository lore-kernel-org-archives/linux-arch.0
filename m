From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2] csky: Fixup 610 vipt cache flush mechanism
Date: Sun, 25 Aug 2019 23:38:18 -0700
Message-ID: <20190826063818.GA29871@infradead.org>
References: <1566443122-17540-1-git-send-email-guoren@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566443122-17540-1-git-send-email-guoren@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: guoren@kernel.org
Cc: arnd@arndb.de, hch@infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org, douzhk@nationalchip.com, Guo Ren <ren_guo@c-sky.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Aug 22, 2019 at 11:05:22AM +0800, guoren@kernel.org wrote:
> From: Guo Ren <ren_guo@c-sky.com>
> 
> 610 has vipt aliasing issue, so we need to finish the cache flush
> apis mentioned in cachetlb.rst to avoid data corruption.
> 
> Here is the list of modified apis in the patch:

Looks sensible to me, although I can't really verify the details.
You might also want to Cc linux-mm.
