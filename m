From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH -mm] clean up duplicated alloc/free_thread_info
Date: Wed, 4 Jun 2008 10:46:32 +0200
Message-ID: <20080604104632.45299954@hskinnemo-gx745.norway.atmel.com>
References: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
	<20080603123112.0d58e193@hskinnemo-gx745.norway.atmel.com>
	<20080604080242P.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758916AbYFDIqa@vger.kernel.org>
In-Reply-To: <20080604080242P.fujita.tomonori@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
Cc: fujita.tomonori@lab.ntt.co.jp, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
List-Id: linux-arch.vger.kernel.org

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> I can just remove the duplicated defines on avr32 since avr32 has
> THREAD_SIZE_ORDER define and uses __get_free_pages/free_pages.

Yeah, that should do it. Thanks!

Haavard
