From: Christoph Lameter <cl@linux.com>
Subject: Re: [guv v2 02/31] percpu: Make __verify_pcu_ptr handle per cpu
 pointers to arrays
Date: Mon, 26 Aug 2013 21:06:16 +0000
Message-ID: <00000140bc72d488-cede7e7a-fef2-41a6-8355-2dc481b6b665-000000@email.amazonses.com>
References: <20130826204138.307369532@linux.com> <00000140bc5bf84a-56dd6082-f1d6-4cee-b8dd-cc4e5c27a911-000000@email.amazonses.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from a193-30.smtp-out.amazonses.com ([199.255.193.30]:56815 "EHLO
	a193-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751712Ab3HZVPx (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Aug 2013 17:15:53 -0400
In-Reply-To: <00000140bc5bf84a-56dd6082-f1d6-4cee-b8dd-cc4e5c27a911-000000@email.amazonses.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: akpm@linuxfoundation.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org

Sorry about the dups. I had an " missing in an CC statement which caused
the mailer to continue to allocate memory until it went oom.
