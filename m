Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from brick.kernel.dk ([87.55.233.238]:20756 "EHLO kernel.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752989AbYDVREN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Tue, 22 Apr 2008 13:04:13 -0400
Date: Tue, 22 Apr 2008 19:04:06 +0200
From: Jens Axboe <jens.axboe@oracle.com>
Subject: Re: [PATCH 1/11] Add generic helpers for arch IPI function calls
Message-ID: <20080422170405.GO12774@kernel.dk>
References: <1208851058-8500-1-git-send-email-jens.axboe@oracle.com> <1208851058-8500-2-git-send-email-jens.axboe@oracle.com> <alpine.LFD.1.10.0804220735350.2779@woody.linux-foundation.org> <20080422145105.GJ12774@kernel.dk> <alpine.LFD.1.10.0804220759020.2779@woody.linux-foundation.org> <20080422164947.GN12774@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080422164947.GN12774@kernel.dk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de
Message-ID: <20080422170406.utKe8erpkkSIOTS3McicRypFEPmr0ZBGT5hTKnJmGR0@z>

On Tue, Apr 22 2008, Jens Axboe wrote:
> +		data = kmalloc(sizeof(*data), GFP_ATOMIC);
> +		if (!unlikely(!data)) {

Woops. I'll test everything and send out the full series, at least the
intention should have been clear.

-- 
Jens Axboe

