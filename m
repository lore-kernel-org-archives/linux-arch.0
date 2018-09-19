Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:47896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbeISLZP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Sep 2018 07:25:15 -0400
Date: Tue, 18 Sep 2018 22:48:59 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [REVIEW][PATCH 06/20] signal/x86: Move mpx siginfo generation
 into do_bounds
Message-ID: <20180919054859.GB32263@infradead.org>
References: <87y3bzk6yv.fsf@xmission.com>
 <20180918000546.12552-6-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918000546.12552-6-ebiederm@xmission.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Message-ID: <20180919054859.Nh7YGUFryvenWHrmwB7WnjMUIDqt3cGkB-ufa5ryEPM@z>

> +struct mpx_fault_info
> +{

Normal kernel style would be:

struct mpx_fault_info {
