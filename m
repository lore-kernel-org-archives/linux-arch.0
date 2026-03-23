Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64BDE381AFD
	for <linux-arch@vger.kernel.org>; Mon, 23 Mar 2026 22:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303245; cv=none; b=LB5WM2kCtTBBdxbGJrjzDkKpLfUJezOQAUJvevXEShWy0RlW6qTUYq40w8pIMndl2jzpE59NCSZ6nMFcQ88H0aGDJr0vvQPkVGhjvEhllgdXVpKBilpS9ZT+RxluiSNKRInwqPloCSHpDcJyvOv14INozt3YhcWyBT+zFbAzhU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303245; c=relaxed/simple;
	bh=McxXbCGfFHQZMM/y6JBW1R1bqzczsOohNoGJ1MHJBEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C7070D+mD8g2C09ni8MFXz++Q4PKreaKbNooRWdS3eqDZ1Bi0/Tws1xEjf6ggKrJujcqaXCe9ogzFU+2wLnr/Hfy2+AQxaFZOeyQii/Ibpvl/UovRJNDeVeITHs7tfuQu/60iubbQxKraC4nBrVmXhGBqKxqM2agMkMfH2GVwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=O3Hwuh/b; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="O3Hwuh/b"
X-KPN-MessageId: b6e180f2-2703-11f1-89dd-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b6e180f2-2703-11f1-89dd-00505699b430;
	Mon, 23 Mar 2026 23:00:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jjZUAFOJ6pjbRga9P2j51i+DzDYQiCJFD9k1yBExLH4=;
	b=O3Hwuh/bG3rHtePmewhj6SVEIe9U0n697qhMZzSLzYGHnmsI/59igN6+B6UJTISCHH6/W4h8Jdye/
	 VwjQkER9455JHZzwkuWREghsDDqqbH5wdFmb+jQTWDUbSZYMJjsD2NBDD9rAWXP5GiPaU734ItEf7W
	 5Lp/yN0wKc1INezkwKa8esRTslprc2MV74vuR/Hzi//7CMzBkS3p5EVOCi0g2r2EGsYQt7TKH+PYKa
	 2spKIR3eyvfRjwYUi1dVKvZ3DdNER03ji5kx2mnVJvrqMYZe/7H3hD1fMusVXrXHLMpgP9MHyf6ZEt
	 BDwopxByuQm1sJu2QcsN2jvWaqYizkg==
X-KPN-MID: 33|jJGGxRjuEBLtzypStpcEWD6y0bSKwpwcayxlBLpirBZwJy5kcK+aI016m8PFJOc
 MswrKT2PNO+B5wpXK93ct4g==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|aH62AvT/SopPvXdNiR2PuYGVvQSeX3wm4G/myhYLRWia01jZ+foRQ2zGZpLhNJQ
 ZH5Jz0upRa7c3ATQ1SIv9Qg==
Received: from daedalus.home (unknown [178.229.142.171])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b3f0f231-2703-11f1-8d40-00505699b758;
	Mon, 23 Mar 2026 23:00:33 +0100 (CET)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Alexander Aring <alex.aring@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>,
	gregkh@linuxfoundation.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>,
	Kees Cook <kees@kernel.org>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Ethan Tidmore <ethantidmore06@gmail.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	wangzijie <wangzijie1@honor.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH 0/1] vfs: transitive upgrade restrictions for fds
Date: Mon, 23 Mar 2026 23:00:21 +0100
Message-ID: <20260323220029.765874-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add upgrade restrictions to openat2(). Extend struct open_how to allow
setting transitive restrictions on using file descriptors to open other
files. A use case for this feature is to block services or containers
from re-opening/upgrading an O_PATH file descriptor through e.g.
/proc/<pid>/fd/<nr> or OPENAT2_EMPTY_PATH (if upstreamed) as O_WRONLY.

The implementation idea is this: magic paths like /proc/<pid>/fd/<nr>
(currently the only one of its sort AFAIK) go through nd_jump_link() to
hard set current->nameidata. To include information about the fd
yielding the magic link, we add a new struct jump_how as a parameter.
This struct may include restictions or other metadata attached to the
magic link jump other than the struct path to jump to. So far it has
only one unsigned int field: allowed_upgrades. This is a flag int that
(for now) may be either READ_UPGRADABLE, WRITE_UPGRADABLE, or
DENY_UPGRADES.

The idea is that you can restrict what kind of open flags may be used
to open files in any way using this fd as a starting point
(transitively). The check is enforced in may_open_upgrade(), which is
just the old may_open() with an extra test. To keep this state attached
to the fds, we add a field f_allowed_upgrades to struct file. Then
in do_open(), after success, we compute:

	file->f_allowed_upgrades =
		op->allowed_upgrades & nd->allowed_upgrades;

where op is the struct open_flags that is build from open_how in
build_open_flags(), and nd->allowed_upgrades is set during path
traversal either in path_init() or nd_jump_link().

The implementation and the idea are a bit rough; it is the first bit of
less trivial work I have done on the kernel, hence the RFC status. I did
create some self tests already which this patch passes, and nothing
seems to break on a fresh vng kernel. But obviously there may be MANY
things I am overlooking.

The original idea for this features comes form the UAPI group kernel
feature idea list [1].

[1] https://github.com/uapi-group/kernel-features?tab=readme-ov-file#upgrade-masks-in-openat2

Jori Koolstra (1):
  vfs: transitive upgrade restrictions for fds

 fs/file_table.c                  |  2 ++
 fs/internal.h                    |  1 +
 fs/namei.c                       | 38 ++++++++++++++++++++++++++++----
 fs/open.c                        |  9 ++++++++
 fs/proc/base.c                   | 24 ++++++++++++++------
 fs/proc/fd.c                     |  6 ++++-
 fs/proc/internal.h               |  4 +++-
 include/linux/fcntl.h            |  6 ++++-
 include/linux/fs.h               |  1 +
 include/linux/namei.h            | 15 ++++++++++++-
 include/uapi/asm-generic/fcntl.h |  4 ++++
 include/uapi/linux/openat2.h     |  1 +
 12 files changed, 96 insertions(+), 15 deletions(-)

-- 
2.53.0

