Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Wed, 9 Feb 2005 12:04:41 -0800
From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [patch] Fix shmget for ppc64, s390-64 & sparc64.
Message-Id: <20050209120441.1b76a7f8.davem@davemloft.net>
In-Reply-To: <20050209134342.GA5716@mschwid3.boeblingen.de.ibm.com>
References: <20050209134342.GA5716@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, anton@samba.org, linux-arch@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>

On Wed, 9 Feb 2005 14:43:42 +0100
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> Hi folks,
> the patch for the shmget > 2GB problem. Please review,
> Dave, Anton?

The sparc64 part looks fine.
