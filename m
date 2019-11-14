From: Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs: add new O_MNT flag for opening mount root from
 mountpoint fd
Date: Thu, 14 Nov 2019 14:13:20 +0000
Message-ID: <20191114141320.GI26530@ZenIV.linux.org.uk>
References: <20191114090454.27903-1-ptikhomirov@virtuozzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20191114090454.27903-1-ptikhomirov@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: Jeff Layton <jlayton@kernel.org>, "J . Bruce Fields" <bfields@fieldses.org>, Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>, Richard Guy Briggs <rgb@redhat.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
List-Id: linux-arch.vger.kernel.org

On Thu, Nov 14, 2019 at 12:04:54PM +0300, Pavel Tikhomirov wrote:

> More precisely the algorithm is:
> a) openat mpfd to a new mountpoint through parent mount's root -
> p_rootfd (which we already have) or mountpoint fd under a sibling mount
> - s_mpfd if our mountpoint is already overmounted.
> b) create a new mount on mpfd via /proc/<pid>/fd/<N> interface
> c) openat it's rootfd via O_MNT from mpfd
> 
> If we have mpfd and rootfd for each mount through /proc/<pid>/fd/<N>
> interface we will be able to bindmount any part of each of already
> created mounts to restore other mounts  and we will be able to configure
> mounts, e.g. change sharing or other options even if mounts are
> invisible from fs-root.

Everything else aside (and I'm not thrilled about the idea in general),
you are not handling the situation when that overmount is, in turn,
overmounted.  Or when there's an automount set on top of it, etc.
