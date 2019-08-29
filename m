From: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Subject: [PATCH v2 0/2] powerpc: Add PowerPC Capabilities ELF note
Date: Thu, 29 Aug 2019 12:50:19 -0300
Message-ID: <20190829155021.2915-1-maxiwell@linux.ibm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linuxppc-dev@ozlabs.org
Cc: kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, paulus@ozlabs.org, mpe@ellerman.id.au, andmike@linux.ibm.com, linuxram@us.ibm.com, bauerman@linux.ibm.com, cclaudio@linux.ibm.com, "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
List-Id: linux-arch.vger.kernel.org

The first patch adds the PowerPC name and the PPC_ELFNOTE_CAPABILITIES
type in the kernel binary ELF note. This type is a bitmap that can be
used to advertise kernel capabilities to userland.

The second patch adds a new documentation file to detail the
ELF Note PowerPC namespace and the PPC_ELFNOTE_CAPABILITIES type.

V2:
* Create the header arch/powerpc/include/asm/elfnote.h with the
  new type PPC_ELFNOTE_CAPABILITIES
* Add documentation file in powerpc dir

Claudio Carvalho (1):
  powerpc: Add PowerPC Capabilities ELF note

Maxiwell S. Garcia (1):
  docs: powerpc: Add ELF note documentation

 Documentation/powerpc/elfnote.rst  | 42 ++++++++++++++++++++++++++++++
 arch/powerpc/include/asm/elfnote.h | 24 +++++++++++++++++
 arch/powerpc/kernel/Makefile       |  2 +-
 arch/powerpc/kernel/note.S         | 40 ++++++++++++++++++++++++++++
 4 files changed, 107 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/powerpc/elfnote.rst
 create mode 100644 arch/powerpc/include/asm/elfnote.h
 create mode 100644 arch/powerpc/kernel/note.S

-- 
2.20.1
