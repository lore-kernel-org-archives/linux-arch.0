From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] percpu-rwsem: use barrier in unlock path
Date: Wed, 17 Oct 2012 10:56:35 +0100
Message-ID: <20121017105635.7623af47@pyramind.ukuu.org.uk>
References: <Pine.LNX.4.64.1210151716310.10685@file.rdu.redhat.com>
	<Pine.LNX.4.64.1210161924350.20581@file.rdu.redhat.com>
	<CA+55aFyZ9uq_yfHn9PwpmM77X3xVd+xseEbjJmeCCqbFddtjWA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:42559 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752101Ab2JQJvo (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Wed, 17 Oct 2012 05:51:44 -0400
In-Reply-To: <CA+55aFyZ9uq_yfHn9PwpmM77X3xVd+xseEbjJmeCCqbFddtjWA@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org

> a later stores, and stores are viewed in program order, so all x86
> stores have "release consistency" modulo the theoretical PPro bugs
> (that I don't think we actually ever saw in practice).

We did seem the for real. The PPro is on its way out however so I hardly
thing we care about optimising for that case.

Alan
