Return-Path: <linux-arch-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15303 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751602AbaLXOCk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
	Wed, 24 Dec 2014 09:02:40 -0500
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
In-Reply-To: <1419423766-114457-8-git-send-email-kirill.shutemov@linux.intel.com>
References: <1419423766-114457-1-git-send-email-kirill.shutemov@linux.intel.com>
 <1419423766-114457-8-git-send-email-kirill.shutemov@linux.intel.com>
Subject: [PATCHv2 07/38] mm: remove rest usage of VM_NONLINEAR and pte_file()
Content-Transfer-Encoding: 7bit
Message-ID: <20141224140205.92CDBA6@black.fi.intel.com>
Date: Wed, 24 Dec 2014 16:02:05 +0200 (EET)
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-arch.vger.kernel.org>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: akpm@linux-foundation.org, peterz@infradead.org, mingo@kernel.org, davej@redhat.com, sasha.levin@oracle.com, hughd@google.com, linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <20141224140205.i_iC2fTk-bgAvyGV6eRQV7owR1AcwQtYsjqzTYK6Xic@z>
