Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from smtpeu1.atmel.com ([195.65.72.27]:32991 "EHLO bagnes.atmel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752444AbYFDIqT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 4 Jun 2008 04:46:19 -0400
Date: Wed, 4 Jun 2008 10:46:32 +0200
From: Haavard Skinnemoen <haavard.skinnemoen@atmel.com>
Subject: Re: [PATCH -mm] clean up duplicated alloc/free_thread_info
Message-ID: <20080604104632.45299954@hskinnemo-gx745.norway.atmel.com>
In-Reply-To: <20080604080242P.fujita.tomonori@lab.ntt.co.jp>
References: <20080603140620S.fujita.tomonori@lab.ntt.co.jp>
	<20080603123112.0d58e193@hskinnemo-gx745.norway.atmel.com>
	<20080604080242P.fujita.tomonori@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, akpm@linux-foundation.org
Message-ID: <20080604084632.oTQ9NbwJ3W5OYETfIOsd0XKSovvPeDybNghGkuRjC_c@z>

FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp> wrote:
> I can just remove the duplicated defines on avr32 since avr32 has
> THREAD_SIZE_ORDER define and uses __get_free_pages/free_pages.

Yeah, that should do it. Thanks!

Haavard
