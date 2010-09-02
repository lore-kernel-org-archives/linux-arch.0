From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 1/3] Drop a couple of unnecessary asm/include.h inclusions
Date: Thu, 02 Sep 2010 11:48:11 +0100
Message-ID: <20430.1283424491@redhat.com>
References: <20100902102153.19806.82031.stgit@warthog.procyon.org.uk> <19747.1283422807@redhat.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:3834 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751022Ab0IBKsa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Thu, 2 Sep 2010 06:48:30 -0400
In-Reply-To: <20100902102153.19806.82031.stgit@warthog.procyon.org.uk>
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
Cc: dhowells@redhat.com, gerg@snapgear.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org

David Howells <dhowells@redhat.com> wrote:

> Drop inclusions of asm/include.h from linux/hardirq.h and linux/list.h as

asm/include.h should read asm/system.h here and in the subject.

David
