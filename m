Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:58709 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754351AbYD0PSX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Sun, 27 Apr 2008 11:18:23 -0400
Message-ID: <48149937.6080505@goop.org>
Date: Sun, 27 Apr 2008 08:18:15 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/11] x86: convert to generic helpers for IPI function
  calls
References: <1208890227-24808-1-git-send-email-jens.axboe@oracle.com> <1208890227-24808-3-git-send-email-jens.axboe@oracle.com> <4812CF5B.4080902@goop.org> <20080427102335.GS12774@kernel.dk>
In-Reply-To: <20080427102335.GS12774@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, npiggin@suse.de, torvalds@linux-foundation.org, peterz@infradead.org, sam@ravnborg.org
Message-ID: <20080427151815.cpmxcHpY9UY-0FGwVagE0PnAOoERMskAw1hKh5T8zAU@z>

Jens Axboe wrote:
> Noted, I'll add it to smp_ops (like smp_call_function_mask() was
> before).
>   

Yep, exactly.

    J
