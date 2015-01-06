From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 14/40] sparc32/uaccess: fix sparse errors
Date: Tue, 06 Jan 2015 13:21:42 -0500 (EST)
Message-ID: <20150106.132142.1678595386163631972.davem@davemloft.net>
References: <1420558883-10131-1-git-send-email-mst@redhat.com>
	<1420558883-10131-15-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <1420558883-10131-15-git-send-email-mst@redhat.com>
Sender: sparclinux-owner@vger.kernel.org
To: mst@redhat.com
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org, sam@ravnborg.org, sparclinux@vger.kernel.org
List-Id: linux-arch.vger.kernel.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Tue, 6 Jan 2015 17:44:17 +0200

> virtio wants to read bitwise types from userspace using get_user.  At the
> moment this triggers sparse errors, since the value is passed through an
> integer.
> 
> Fix that up using __force.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>


