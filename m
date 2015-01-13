From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 01/40] x86/uaccess: fix sparse errors
Date: Tue, 13 Jan 2015 13:33:56 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1501131333410.5526@nanos>
References: <1420558883-10131-1-git-send-email-mst@redhat.com> <1420558883-10131-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420558883-10131-2-git-send-email-mst@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
List-Id: linux-arch.vger.kernel.org

On Tue, 6 Jan 2015, Michael S. Tsirkin wrote:

> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: Thomas Gleixner <tglx@linutronix.de>
