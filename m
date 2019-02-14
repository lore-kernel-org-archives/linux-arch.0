From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 0/4] provide a generic free_initmem implementation
Date: Thu, 14 Feb 2019 18:04:16 +0100
Message-ID: <20190214170416.GA32441@lst.de>
References: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1550159977-8949-1-git-send-email-rppt@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, Palmer Dabbelt <palmer@sifive.com>, Richard Kuo <rkuo@codeaurora.org>, linux-arch@vger.kernel.org, linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-riscv@lists.infradead.org
List-Id: linux-arch.vger.kernel.org

This look fine to me, but I'm a little worried that as-is this will
just create conflicts with my series..
