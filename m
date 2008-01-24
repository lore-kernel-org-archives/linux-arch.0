Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from stinky.trash.net ([213.144.137.162]:38144 "EHLO
	stinky.trash.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753319AbYAXJop (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 24 Jan 2008 04:44:45 -0500
Message-ID: <47985DD4.3000706@trash.net>
Date: Thu, 24 Jan 2008 10:43:48 +0100
From: Patrick McHardy <kaber@trash.net>
MIME-Version: 1.0
Subject: Re: [resend][PATCH] Introducing socket mark socket option
References: <47974D07.5040202@trash.net> <1201167495912-git-send-email-panther@balabit.hu>
In-Reply-To: <1201167495912-git-send-email-panther@balabit.hu>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Laszlo Attila Toth <panther@balabit.hu>
Cc: Netfilter Developer Mailing List <netfilter-devel@vger.kernel.org>, netdev@vger.kernel.org, linux-arch@vger.kernel.org

Laszlo Attila Toth wrote:
> A userspace program may wish to set the mark for each packets its send
> without using the netfilter MARK target. Changing the mark can be used
> for mark based routing without netfilter or for packet filtering.
> 
> It requires CAP_NET_ADMIN capability.


Looks good to me.
