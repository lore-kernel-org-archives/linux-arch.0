From: David Howells <dhowells@redhat.com>
Subject: Re: [guv v2 04/31] net: Replace __get_cpu_var uses
Date: Mon, 02 Sep 2013 22:35:06 +0100
Message-ID: <7435.1378157706@warthog.procyon.org.uk>
References: <00000140bc5ef9df-d7f75909-a25e-4471-84b2-dfbec07117b0-000000@email.amazonses.com> <20130826204351.725357339@linux.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:27524 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758723Ab3IBVfQ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Mon, 2 Sep 2013 17:35:16 -0400
In-Reply-To: <00000140bc5ef9df-d7f75909-a25e-4471-84b2-dfbec07117b0-000000@email.amazonses.com>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Christoph Lameter <cl@linux.com>
Cc: dhowells@redhat.com, Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org, "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-arch@vger.kernel.org, Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org


Would it be possible to use __thread annotations for per-CPU variables, I
wonder?

David
