Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:43453 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754256Ab1EIUAC (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 9 May 2011 16:00:02 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH 0/7] Network namespace manipulation with file descriptors
References: <m1tyd7p7tq.fsf@fess.ebiederm.org>
	<20110509.120408.48494155.davem@davemloft.net>
Date: Mon, 09 May 2011 12:59:55 -0700
In-Reply-To: <20110509.120408.48494155.davem@davemloft.net> (David Miller's
	message of "Mon, 09 May 2011 12:04:08 -0700 (PDT)")
Message-ID: <m1oc3btzk4.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, hadi@cyberus.ca, daniel.lezcano@free.fr, containers@lists.osdl.org, renatowestphal@gmail.com
Message-ID: <20110509195955.Bbd7b5pfIHEwroRaNIOn6A2b0oT5nDcMZMs2OxLjugo@z>

David Miller <davem@davemloft.net> writes:

> The networking bits look OK to me:
>
> Acked-by: David S. Miller <davem@davemloft.net>

Are you merging sendmmsg through the netdev tree?

The conflicts on syscall syscall numbers are an unfortunate pain.

Eric

