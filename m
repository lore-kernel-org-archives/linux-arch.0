Return-Path: <davem@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:7329 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265305AbUGZT5Y (ORCPT
	<rfc822;linux-arch@vger.kernel.org>);
	Mon, 26 Jul 2004 15:57:24 -0400
Date: Mon, 26 Jul 2004 12:55:53 -0700
From: "David S. Miller" <davem@redhat.com>
Subject: Re: compat_clock_getres shouldn't return -EFAULT if res == NULL
Message-Id: <20040726125553.7f8502be.davem@redhat.com>
In-Reply-To: <410560C1.1060804@intel.com>
References: <410560C1.1060804@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Arun Sharma <arun.sharma@intel.com>
Cc: akpm@osdl.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Mon, 26 Jul 2004 12:51:29 -0700
Arun Sharma <arun.sharma@intel.com> wrote:

> Description within the patch.

Looks good.
