From: Christoph Lameter <cl@linux-foundation.org>
Subject: Re: [PATCH 6/9 UPDATED] percpu: enforce global definition
Date: Thu, 18 Jun 2009 09:51:46 -0400 (EDT)
Message-ID: <alpine.DEB.1.10.0906180951270.15556@gentwo.org>
References: <1245210060-24344-1-git-send-email-tj@kernel.org>  <1245210060-24344-7-git-send-email-tj@kernel.org>  <4A39EF13.7010309@kernel.org> <1245331597.5195.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from smtp3.ultrahosting.com ([74.213.175.254]:37882 "EHLO
	smtp.ultrahosting.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755551AbZFRNwQ (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Thu, 18 Jun 2009 09:52:16 -0400
In-Reply-To: <1245331597.5195.8.camel@localhost.localdomain>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: Steven Rostedt <srostedt@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org, mingo@elte.hu, kyle@mcmartin.ca, Jesper.Nilsson@axis.com, benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, David Howells <dhowells@redhat.com>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, arm@redhat.com

On Thu, 18 Jun 2009, Steven Rostedt wrote:

> Uh, wont this cause name space collisions?

There was an earlier cleanup patch that deal with potential collisions.
