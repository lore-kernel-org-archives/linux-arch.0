Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:38590 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262251AbUCAF4p (ORCPT
	<rfc822;linux-arch@vger.kernel.org>); Mon, 1 Mar 2004 00:56:45 -0500
Date: Sun, 29 Feb 2004 21:56:32 -0800
From: "David S. Miller" <davem@redhat.com>
Subject: Re: compat tasks and O_LARGEFILE
Message-Id: <20040229215632.543c084a.davem@redhat.com>
In-Reply-To: <20040229023802.GB6964@intel.com>
References: <20040228015709.GB6897@intel.com>
	<20040228155626.4e45aaa6.davem@redhat.com>
	<20040229023802.GB6964@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Sat, 28 Feb 2004 18:38:02 -0800
Arun Sharma <arun.sharma@intel.com> wrote:

> This approach doesn't work for completely user level 32 bit emulation.

If the emulation is completely user level, then you're asking to modify the
64-bit syscall behavior, and that's more of a linux-kernel topic probably?
