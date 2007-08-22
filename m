Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:36777 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762054AbXHVJHE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 22 Aug 2007 05:07:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20070821193835.258D7DD4@kernel>
References: <20070821193835.258D7DD4@kernel>
Subject: Re: [RFC][PATCH] introduce TASK_SIZE_OF() for all arches
Date: Wed, 22 Aug 2007 10:06:55 +0100
Message-ID: <31048.1187773615@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
To: Dave Hansen <haveblue@us.ibm.com>
Cc: dhowells@redhat.com, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

Dave Hansen <haveblue@us.ibm.com> wrote:

> For the /proc/<pid>/pagemap code[1], we need to able to query how
> much virtual address space a particular task has.

How does this relate to NOMMU conditions?

David
